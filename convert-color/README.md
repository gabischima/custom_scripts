# convert color
color converter: Hex to RGB

## usage
```
Convert HEX color to RGB
-----------------------------------------------------------
-c | --color         Color value in HEX
-1 | --base1         Flag for RGB numbers on base 1
-a | --alpha         Flag to display RGB with alpha value
-o | --opacity       Flag to display RGB with opacity value
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

## to do
- [ ] RGB to HEX
