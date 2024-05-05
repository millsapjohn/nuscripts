export def generate_git_code [dir: path] {
 let git_string = (git fetch; git status)
 let init = $'(ansi green)('g')'
 mut staged = ""
 mut commit = ""
 mut track = ""
 mut pull = ""
 if ($git_string | str contains "To be committed") {
  $commit = $'(ansi orange)('c')'
 } 
 if ($git_string | str contains "Untracked files") {
  $track = $'(ansi yellow)('u')'
 } 
 if ($git_string | str contains "text") {
  $pull = $'(ansi red)('p')'
 }
 if ($git_string | str contains "not staged") {
  $staged = $'(ansi yellow)('n')'
 }
 [$init, $staged, $commit, $track, $pull] | str join
}
