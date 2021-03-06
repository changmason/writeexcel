# -*- coding: utf-8 -*-

require 'writeexcel/caller_info'

if defined?($debug)
  class BIFFWriter
    include CallerInfo

    def append(*args)
      data = args.collect{ |arg| arg.dup.force_encoding('ASCII-8BIT') }.join
      print_caller_info(data, :method => 'append')
      super
    end

    def prepend(*args)
      data = args.collect{ |arg| arg.dup.force_encoding('ASCII-8BIT') }.join
      print_caller_info(data, :method => 'prepend')
      super
    end

    def print_caller_info(data, param = {})
      infos = caller_info

      print "#{param[:method]}\n" if param[:method]
      infos.each do |info|
        print "#{info[:file]}:#{info[:line]}"
        print " in #{info[:method]}" if info[:method]
        print "\n"
      end
      print data.unpack('C*').map! {|byte| sprintf("%02X", byte) }.join(' ') + "\n\n"
    end
  end
end
