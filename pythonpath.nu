module pythonpath {
 export-env {
  if ($nu.default-config-dir | path join "pythonpath.nuon" | path exists) {
   if $nu.os-info.name == "windows" {
    let pathlist = ($nu.default-config-dir | path join "pythonpath.nuon" | open | get windowspaths)
   } else {
    let pathlist = ($nu.default-config-dir | path join "pythonpath.nuon" | open | get linuxpaths)
   }
   let pathstring = (pathlist | reduce {|it, acc| $acc + $it + ";"})
   load-env {PYTHONPATH: pathstring}
  } else {
   print "error loading Python paths; pythonpath.nuon does not exist"
  }
 }
}
