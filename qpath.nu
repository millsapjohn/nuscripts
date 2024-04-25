export-env {
 if ($nu.default-config-dir | path join "qpath.nuon" | path exists) {
  if $nu.os-info.name == "windows" {
   load-env {PYTHONPATH: ($nu.default-config-dir | path join "qpath.nuon" | open | get windowspaths | reduce {|it, acc| $acc + $it + ";"})}
  } else {
   load-env {PYTHONPATH: ($nu.default-config-dir | path join "qpath.nuon" | open | get linuxpaths | reduce {|it, acc| $acc + $it + ";"})}
  }
 } else {
  print $"error loading QGIS Python paths; ($nu.default-config-dir | path join "qpath.nuon") does not exist"
 }
}
