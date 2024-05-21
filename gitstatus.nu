def gist [] {
 for x in $env.gitpaths {
  let git_string = (git -C $x fetch;git -C $x status)
  if 'clean' in $git_string {
   print $"(ansi green)clean: (ansi reset)($x)"
  } else if 'behind' in $git_string {
   print $'(ansi red)behind: (ansi reset)($x)'
  } else if 'to be committed' in $git_string {
   print $"(ansi yellow)uncommitted changes: (ansi reset)($x)"
  } else if 'untracked files present' in $git_string {
   print $"(ansi yellow)untracked files: (ansi reset)($x)"
  }
 }
}
