def completions [] {$env.exclude_list}

# add, remove, and edit items to be excluded from ls when changing directory
export def --env exclude [] {
 print $env.exclude_list
}

export def --env "exclude add" [name: string] {
 if $name not-in $env.exclude_list {
  $env.exclude_list = ($env.exclude_list | append $name)
  $env.exclude_list | save -f ($nu.default-config-dir | path join "exclude.nuon")
 } else {
  "already in exclude list"
 }
}

export def --env "exclude remove" [name: string@completions] {
 if $name in $env.exclude_list {
  $env.exclude_list = ($env.exclude_list | where ($it != $name))
  $env.exclude_list | save -f ($nu.default-config-dir | path join "exclude.nuon")
 } else {
  "not in exclude list"
 }
}
