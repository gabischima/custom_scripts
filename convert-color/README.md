# convert color
color converter: Hex to RGB

## usage
```
$ sh convert-color.sh [-c|--color] 000000 [-a|-alpha] [-o|--opacity] [-1|--base1] [--copy]

Convert HEX color to RGB
-----------------------------------------------------------
-c | --color         Pass color value in HEX
-1 | --base1         RGB numbers on base 1
-a | --alpha         Display RGB with alpha value
-o | --opacity       Display RGB with opacity value
--copy               Copy result to clipboard
-h | --help          Print usage
-----------------------------------------------------------
```

### color
```
$ sh convert-color.sh [--color|-c] 000000
---------------------------------------------
rgb color
(red: 0, green: 0, blue: 0)
---------------------------------------------
```

### --base1
```
$ sh convert-color.sh [--color|-c] E19B9B [-1|--base1]
---------------------------------------------
rgb color
(red: 0.88, green: 0.61, blue: 0.61)
---------------------------------------------
```

### --alpha
```
$ sh convert-color.sh [--color|-c] 000000 [-a|--alpha]
---------------------------------------------
rgba color
(red: 0, green: 0, blue: 0, alpha: 1.0)
---------------------------------------------
```

### --opacity
```
$ sh convert-color.sh [--color|-c] 000000 [-o|--opacity]
---------------------------------------------
rgbo color
(red: 0, green: 0, blue: 0, opacity: 1.0)
---------------------------------------------
```

### --copy
```
$ sh convert-color.sh [--color|-c] 000000 --copy
---------------------------------------------
rgbo color
(red: 0, green: 0, blue: 0)
---------------------------------------------
```

the result `(red: 0, green: 0, blue: 0)` is copied to clipboard

## to do
- [ ] RGB to HEX
