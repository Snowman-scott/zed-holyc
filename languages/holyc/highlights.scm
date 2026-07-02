; extends

; --- 0. CUSTOM HOLYC EXTENSIONS ---
((identifier) @keyword.function (#eq? @keyword.function "_extern"))
((identifier) @keyword.function (#eq? @keyword.function "asm"))
((identifier) @keyword.function (#eq? @keyword.function "_asm"))

; --- 1. BYPASS C PARSER ERRORS ---
"extern" @keyword

((ERROR (identifier) @keyword)
 (#eq? @keyword "extern"))

((ERROR (string_literal) @string))

; --- 2. CHARACTERS AND LITERALS ---
(char_literal) @string
(string_literal) @string
(number_literal) @number

; --- 3. HOLYC PRIMITIVE TYPES & POINTERS ---
((identifier) @type
 (#match? @type "^(I8|I16|I32|I64|U8|U16|U32|U64|F32|F64|U0|Bool|I8i|I16i|I32i|I64i|U8i|U16i|U32i|U64i)$"))

((type_identifier) @type)
((primitive_type) @type)

(pointer_declarator
  declarator: (identifier) @type)

; --- 4. STANDARD & HOLYC KEYWORDS ---
"while" @keyword
"return" @keyword
"if" @keyword
"else" @keyword
"for" @keyword
"switch" @keyword
"case" @keyword
"default" @keyword
"break" @keyword

((identifier) @keyword
 (#match? @keyword "^(auto|lastclass|no_warn|reg|interrupt)$"))

; --- 5. LITERALS & CONSTANTS ---
((identifier) @constant.builtin
 (#match? @constant.builtin "^(TRUE|FALSE|NULL|true|false)$"))

; --- 6. FUNCTIONS & DECLARATIONS ---
(function_declarator
  declarator: (identifier) @function)

(call_expression
  function: (identifier) @function)

; --- 7. COMMENTS ---
(comment) @comment
;(ERROR (comment)) @comment

; --- 8. OPERATORS & POINTER SYMBOLS ---
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"%" @operator
"=" @operator
"==" @operator
"!=" @operator
"<" @operator
">" @operator
"<<" @operator
">>" @operator
"&" @operator
"|" @operator
"^" @operator
"~" @operator
"++" @operator
"--" @operator

; --- 9. NUCLEAR ASSEMBLY OVERRIDES ---

; Force 'asm' to be blue (@function) instead of a pink keyword
"asm" @function
((identifier) @function (#eq? @function "asm"))
((type_identifier) @function (#eq? @function "asm"))
((ERROR (identifier) @function) (#eq? @function "asm"))

; Force instructions (Purple)
((identifier) @keyword (#match? @keyword "^(MOV|SYSCALL)$"))
((type_identifier) @keyword (#match? @keyword "^(MOV|SYSCALL)$"))
((field_identifier) @keyword (#match? @keyword "^(MOV|SYSCALL)$"))
(call_expression function: (identifier) @keyword (#match? @keyword "^(MOV|SYSCALL)$"))
(function_declarator declarator: (identifier) @keyword (#match? @keyword "^(MOV|SYSCALL)$"))
((ERROR (identifier) @keyword) (#match? @keyword "^(MOV|SYSCALL)$"))

; Force registers/constants (Orange)
((identifier) @constant.builtin (#match? @constant.builtin "^(RAX|RDI|RSI|RDX|res)$"))
