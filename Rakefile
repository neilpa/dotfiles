# Rakefile for setting up my dotfiles

DOTFILES = File.expand_path(File.dirname(__FILE__))
HOME = ENV["HOME"]

task :default => :link

# TODO Should these be converted to file tasks instead
task :link do
  # Each config set maps to a directory
  glob('**/*.symlink').each do |source|
    target = "#{HOME}/.#{base(source).ext}"
    symlink_prompt source, target
  end

  # TODO Seperate tasks
  mkdir_p "#{HOME}/bin"
  glob('*/bin/*').each do |source|
    symlink_prompt source, "#{HOME}/bin/#{base(source)}"
  end
end


def glob pattern
  Dir.glob("#{DOTFILES}/#{pattern}")
end

def base file
  File.basename(file)
end

def symlink_prompt source, target
  if File.exist? target
    puts "File (#{target}) alread exists, what do you want to do?"
    print '[s]kip, [r]eplace, [b]ackup, [q]uit? '
    case $stdin.gets.chomp
    when 'r' then replace_file source, target
    when 'b' then backup_file source, target
    when 's' then puts 'skipping'
    when 'q' then exit
    end
  else
    link_file source, target
  end
end

def backup_file source, target
    puts 'backup'
    File.rename target, "#{target}.#{timestamp}.bak"
    link_file source, target
end

def replace_file source, target
    puts 'replace'
    File.delete target
    link_file source, target
end

def link_file source, target
    puts "linking #{target} => #{source}"
    File.symlink source, target
end

def timestamp
    Time.now.strftime '%Y%m%d-%H%M%S'
end

