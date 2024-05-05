def generate_git_code [dir: path] {
 let git_string = (git fetch; git status)
 if (git_string | str contains "untracked files") {
  $'(ansi yellow)(g)'
 } else if (git_string | str contains "text") {
  $'(ansi red)(g)'
 }
}
