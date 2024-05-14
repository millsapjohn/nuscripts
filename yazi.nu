def --env yy [...args] {
 let tmp = (mktemp -t yazi.XXXXXX)
 yazi ...$args --cwd-file $tmp
 let cwd = (open $tmp)
 if $cwd != "" and $cwd != $env.PWD {
  cd $cwd
 }
 rm -fp $tmp
}
