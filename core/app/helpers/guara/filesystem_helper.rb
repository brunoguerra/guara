require "fileutils"

module Guara
  module FilesystemHelper
	def puts_on_file(file, data=nil)
	  FileUtils.makedirs File.dirname(file)
	  data ||= yield
	  aFile = File.new(file, "wb:ASCII-8BIT")
	  aFile.write(data)
	  aFile.close
	end
  end
end