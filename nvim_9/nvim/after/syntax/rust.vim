if exists("b:current_syntax")
    syn match     rustType        display "\<[A-Z][a-zA-Z0-9_']*\>" "Defined types as built types
    syn match     rustAllCaps     display "\<[A-Z][A-Z][A-Z0-9_]*\>" "Constants

    " Default highlighting
    hi def link rustAllCaps rustConstant
end
