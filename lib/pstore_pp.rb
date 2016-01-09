require 'pstore_pp/version'
require 'pstore'
require 'json'

module PStorePP
  module CLI
    class << self
      def start(args = ARGV)
        args = Array(args)

        case args.size
        when 0
          fail 'Error - Missing file name.'
        when 1
          puts JSON.generate(dump(args.first))
        else
          puts JSON.generate(args.map { |file| { file => dump(file) } })
        end
      end

      def dump(file)
        fail "Could not find file: #{file}" unless File.exist?(file)

        store = PStore.new(file)

        store.transaction(true) do
          store.roots.map do |key|
            [key, store[key]]
          end.to_h
        end
      end
    end
  end
end
