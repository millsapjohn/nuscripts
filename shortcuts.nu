def completions [] {$env.shortcuts | get name}

export def --env fly [name: string@completions] {
  let fly_path = (if ($name in ($env.shortcuts | get name)) {
    ($env.shortcuts | where name == $name | get path)
  } else {
    $env.PWD
  })
  cd $fly_path.0
}

export def --env "fly add" [name: string, path?: string] {
  if $name not-in ($env.shortcuts | get name) {
    if ($path != null) {
      $env.shortcuts = ($env.shortcuts | append {name:$name, path:$path})
    } else {
      $env.shortcuts = ($env.shortcuts | append {name:$name, path:$env.PWD})
    }
    $env.shortcuts | save -f ($nu.default-config-dir | path join "shortcuts.nuon")
  } else {
    "shortcut already listed"
  }
}

export def --env "fly remove" [name: string@completions] {
  if $name in ($env.shortcuts | get name) {
    $env.shortcuts = ($env.shortcuts | where ($it | $it.name != $name))
    $env.shortcuts | save -f ($nu.default-config-dir | path join "shortcuts.nuon")
  } else {
    "shortcut not listed"
  }
}
export def "fly list" [] {
  print $env.shortcuts
}