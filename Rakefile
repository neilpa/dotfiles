DOTFILES = File.expand_path(File.dirname(__FILE__))
HOME = File.expand_path('~')

task :default => :symlink

task :symlink do
    src = "#{DOTFILES}/git"
    dest = "#{HOME}/.config/git"

    if File.exist? dest
        puts "File (#{dest}) alread exists, what do you want to do?"

        #TODO print '[s]kip, [S]kip all, [r]eplace, [R]eplace all, [b]ackup, [B]ackup all, [q]uit?'
        print '[s]kip, [r]eplace, [b]ackup, [q]uit? '

        case get_char
        when 'r'
            replace_file src, dest
        when 'b'
            backup_file src, dest
        when 'q'
            exit
        when 's'
            puts 'skipping'
        end
    else
        link_file src, dest
    end
end

def backup_file src, dest
    puts 'backup'
    File.rename dest, "#{dest}.bak"
    link_file src, dest
end

def replace_file src, dest
    puts 'replace'
    File.delete dest
    link_file src, dest
end

def link_file src, dest
    puts 'link'
    File.symlink src, dest
end

# Read user input from STDIN without having to press ENTER
# Take from http://stackoverflow.com/a/14527475
def get_char
  state = `stty -g`
  `stty raw -echo -icanon isig`

  STDIN.getc.chr
ensure
  `stty #{state}`
end


# Cross-platform way of finding an executable in the $PATH.
# Taken from http://stackoverflow.com/a/5471032
#
#   which('ruby') #=> /usr/bin/ruby
def which cmd
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable? exe
    }
  end
  return nil
end

