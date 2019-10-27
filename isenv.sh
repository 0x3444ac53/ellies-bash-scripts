
isvenv(){
    return $(python -c "import sys; exit(not ((hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix))))")
}
