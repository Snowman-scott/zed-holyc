; --- Types ---
[
  "I8" "I16" "I32" "I64"
  "U8" "U16" "U32" "U64"
  "F64" "Bool" "Char" "Void" "U0"
] @type

; --- Keywords ---
["if" "else" "while" "for" "return" "class" "extern" "_extern"] @keyword

; --- Assembly ---
["asm" "_asm"] @keyword
(asm_mnemonic) @keyword.operator
(register) @constant.builtin

; --- Literals ---
(string) @string
(char) @string
(number) @number
(comment) @comment

; --- Built-in constants ---
((identifier) @constant.builtin
  (#match? @constant.builtin "^(TRUE|FALSE|NULL|true|false)$"))

; --- Generic fallback (MUST come before specific identifier rules below) ---
(identifier) @variable

; --- Specific identifier roles (override the fallback above) ---
(function_definition (identifier) @function)
(extern_declaration (identifier) @function)
(call_expression (identifier) @function)
(class_definition (identifier) @type)

; --- Operators ---
[
  "+" "-" "*" "/" "%"
  "=" "==" "!=" "<" ">" "<=" ">="
  "&&" "||" "<<" ">>" "&" "|" "^" "~"
  "++" "--"
  "+=" "-=" "*=" "/=" "%=" "^=" "&=" "|=" "<<=" ">>="
] @operator

; --- Punctuation ---
["(" ")" "{" "}" "[" "]"] @punctuation.bracket
[";" ","] @punctuation.delimiter
