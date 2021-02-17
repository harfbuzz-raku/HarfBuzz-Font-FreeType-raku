unit module HarfBuzz::FreeType::Raw;

use Font::FreeType::Raw;
use HarfBuzz::Raw;
use HarfBuzz::Raw::Defs :$HB, :types;
use NativeCall;

#| A FreeType integrated font face
class hb_ft_font is hb_font is repr('CPointer') is export {
    # FreeType integration
    our sub create(FT_Face --> hb_ft_font) is native($HB) is symbol('hb_ft_font_create_referenced') {*}
    method new(FT_Face :$ft-face! --> hb_font) { create($ft-face) }
    method ft-font-has-changed() is native($HB) is symbol('hb_ft_font_has_changed') {*}
    method ft-set-load-flags(int32) is native($HB) is symbol('hb_ft_font_set_load_flags') {*}
    method ft-get-load-flags(--> int32) is native($HB) is symbol('hb_ft_font_get_load_flags') {*}
    method ft-set-funcs(--> int32) is native($HB) is symbol('hb_ft_font_set_funcs') {*}
}

