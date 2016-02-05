if ARGV.count != 1
	$stderr.puts "ERROR: Pass in a commit range"
	abort()
end

commitRange = ARGV[0]

log = `git log --merges #{commitRange}`

prs = []

currentPR = nil
log.lines.each do |line|
	next if (line =~ /^[\s\r\n]*$/) != nil #skip blank lines

	if (/^    / =~ line) == nil
		if currentPR != nil
			prs.push(currentPR)
			currentPR = nil
		end
		next
	end

	if currentPR == nil
		match = /^    Merge pull request (#[\d]+)/.match(line)
		if match && match.captures.count > 0
			currentPR = match.captures[0]
		end
	else
		currentPR << ' ' << line.strip
		currentPR << '.' unless currentPR[-1] == '.'
	end
end

prs.push(currentPR) if currentPR != nil

puts prs.reverse

exit()
