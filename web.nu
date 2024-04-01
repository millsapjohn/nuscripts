export def main [
  ...terms: string
  --wikipedia (-w) # search Wikipedia
  --crates (-c) # search crates.io
  --github (-g) # search GitHub
  --bing  (-b) # search Bing
  --google (-g) # search Google
  --literal (-l) # enter a web address directly
] {
  if ($literal) {
    if ($terms | length) == 0 {
      "insufficient arguments"
    } else if ($terms | length) > 1 {
      "too many arguments"
    } else {
      start ("https://" + $terms.0)
    }
  } else if ($crates) {
    if ($terms | length) == 0 {
      start "https://crates.io"
    } else if ($terms | length) == 1 {
      start (["https://crates.io/search?q=", $terms.0] | str join)
    } else {
      let prefix = "https://crates.io/search?q="
      let termstr = ($terms | skip 1 | each { |it| ["%", $it] | str join } | reduce { |it, acc| $acc + $it })
      start ([$prefix, $terms.0, $termstr] | str join)
    }
  } else if ($wikipedia) {
    if ($terms | length) == 0 {
      start "https://en.wikipedia.org"
    } else if ($terms | length) == 1 {
      start (["https://en.wikipedia.org/w/index.php?search=", $terms.0] | str join)
    } else {
      let prefix = "https://en.wikipedia.org/w/index.php?search="
      let termstr = ($terms | skip 1 | each { |it| ["+" $it] | str join } | reduce { |it, acc| $acc + $it })
      start ([$prefix, $terms.0, $termstr] | str join)
      }
  } else if ($github) {
    if ($terms | length) == 0 {
      start "https://github.com"
    } else if ($terms | length) == 1 {
      start (["https://github.com/search?q=", $terms.0] | str join)
    } else {
      let prefix = "https://github.com/search?q="
      let termstr = ($terms | skip 1 | each { |it| ["+" $it] | str join } | reduce { |it, acc| $acc + $it })
      start ([$prefix, $terms.0, $termstr] | str join)
    }
  } else if ($bing) {
    if ($terms | length) == 0 {
      start "https://bing.com"
    } else if ($terms | length) == 1 {
      start (["https://bing.com/search?q=", $terms.0] | str join)
    } else {
      let prefix = "https://bing.com/search?q="
      let termstr = ($terms | skip 1 | each { |it| ["+" $it] | str join } | reduce { |it, acc| $acc + $it })
      start ([$prefix, $terms.0, $termstr] | str join)
    }
  } else if ($google) {
    if ($terms | length) == 0 {
      start "https://google.com"
    } else if ($terms | length) == 1 {
      start (["https://google.com/search?q=", $terms.0] | str join)
    } else {
      let prefix = "https://google.com/search?q="
      let termstr = ($terms | skip 1 | each { |it| ["+" $it] | str join } | reduce { |it, acc| $acc + $it })
      start ([$prefix, $terms.0, $termstr] | str join)
    }
  } else {
    if ($terms | length) == 0 {
      start "https://ecosia.org"
    } else if ($terms | length) == 1 {
      start (["https://ecosia.org/search?q=", $terms.0] | str join)
    } else {
      let prefix = "https://ecosia.org/search?q="
      let termstr = ($terms | skip 1 | each { |it| ["+" $it] | str join } | reduce { |it, acc| $acc + $it })
      start ([$prefix, $terms.0, $termstr] | str join)
    }
  }
}
