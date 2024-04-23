export def --env wlink [
 dest?: path # Destination linked file to be created
 src?: path # Target link file to be referenced
 --bid (-b) # Bi-directional (hard) link
 --sym (-s) # One-directional (symbolic) link
 --dir (-d) # Directory link
 --list (-l) # List links in the current directory. Include -b, -s, or -d flags to filter the list by link type
] {
 if $list {
  if $bid {
   ls | where {|it| $it.type == file} | each {|it| $"($it.name) \n (fsutil hardlink list $it.name)"}
  }
 } else if $sym {
  mklink $dest $src
 } else if $bid {
  mklink "/H" $dest $src
 } else if $dir {
  mklink "/D" $dest $src
 }
}
