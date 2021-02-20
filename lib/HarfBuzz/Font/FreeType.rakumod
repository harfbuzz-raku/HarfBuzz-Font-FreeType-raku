use HarfBuzz::Font;

#| A HarfBuzz FreeType face integrated font
unit class HarfBuzz::Font::FreeType:ver<0.0.5>
    is HarfBuzz::Font; #| HarfBuzz FreeType bound font data-type

use HarfBuzz::Raw;
use HarfBuzz::Font::FreeType::Raw;
use Font::FreeType::Face;
has Font::FreeType::Face:D $.ft-face is required;

=begin pod

=head2 Synopsis

   use HarfBuzz::Font::FreeType;
   use HarfBuzz::Shaper;
   use Font::FreeType::Face;
   my  Font::FreeType::Face $ft-face .= new: ...;
   my  HarfBuzz::Font::FreeType() .= %( :$ft-face, :@features, :$size, :@scale );
   my  HarfBuzz::Shaper $shaper .= new: :$font, :buf{ :text<Hello> };

=head2 Description

This modules supports L<FreeType integration|https://harfbuzz.github.io/integration-freetype.html> for the HarfBuzz library.

It may be used to do L<HarfBuzz> shaping from a L<Font::FreeType> object.

=head2 Methods
=end pod


submethod TWEAK(:$funcs = True, Num:D() :$size = 12e0, :@scale) {
    unless @scale {
        my uint32 $sc = ($!ft-face.units-per-EM * $size / 32).round;
        self.raw.set-scale($sc, $sc);
    }

    $!ft-face.set-char-size($size);
    self.raw.ft-set-funcs()
        if $funcs;
}

multi method COERCE(%ops ( :$ft-face!, :$file, |etc) ) {
    warn "ignoring ':file' option" with $file;
    my hb_ft_font $raw = hb_ft_font::create($ft-face.raw);
    my HarfBuzz::Face() $face = $raw.get-face();
    self.new(:$raw, :$face, :$ft-face, |etc)
}

method raw(--> hb_ft_font) handles <ft-set-load-flags ft-get-load-flags ft-font-has-changed> {
    callsame();
}

#| Get or set the FreeType load flags
method ft-load-flags is rw returns Int {
    Proxy.new(
        FETCH => { self.ft-get-load-flags },
        STORE => -> $, UInt:D $flags {
            self.ft-set-load-flags($flags);
        }
    );
}

=begin pod

=head2 See Also



=end pod
