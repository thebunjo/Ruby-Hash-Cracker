require 'digest'

# Get command-line arguments
hash_type, hash_value, wordlist_file = ARGV

# Check arguments
unless hash_type && hash_value && wordlist_file
  puts "Usage: ruby hash_cracker.rb [HASH_TYPE] [HASH_VALUE] [WORDLIST_FILE]"
  exit
end

# Select the appropriate digest algorithm based on the hash type
case hash_type.downcase
when 'md5'
  digest = Digest::MD5
when 'sha1'
  digest = Digest::SHA1
when 'sha256'
  digest = Digest::SHA256
else
  puts "Invalid hash type: #{hash_type}"
  exit
end

# Start the hash cracking process
def crack_hash(digest, hash_value, wordlist_file)
  # Hash cracking process
  passwords = File.readlines(wordlist_file)
  passwords.each do |password|
    password = password.chomp
    password_hash = digest.hexdigest(password)
    if password_hash == hash_value
      puts "Password Found: #{password}"
      return
    end
  end

  puts "Password not found."
end

crack_hash(digest, hash_value, wordlist_file)
