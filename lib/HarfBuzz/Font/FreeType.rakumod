use HarfBuzz::Font;

#| A HarfBuzz FreeType face integrated font
unit class HarfBuzz::Font::FreeType:ver<0.0.10>
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

Note that HarfBuzz can load OpenType and TrueType format fonts directly. The FreeType integration most likely to be useful for
other font formats, that can be loaded by [Font::FreeType](https://harfbuzz-raku.github.io/Font-FreeType-raku/).

=head2 Methods

=para This class inherits from L<HarfBuzz::Font> and has all its methods available.
=end pod

submethod TWEAK(:$funcs = True) {
    self.raw.ft-set-funcs()
        if $funcs;
}

=begin pod
    =head3 new
    =begin code :lang<raku>
    use Font::FreeType::Face;
    use HarfBuzz::Font::FreeType;
    method new(
        Font::FreeType::Face:D :$ft-face!, # FreeType face
        Bool  :$funcs = True,              # use FreeType functions
        Num() :$size = 12e0,               # font size (points)
        :@scale,                           # font scale [x, y?]
    ) returns HarfBuzz::Font::FreeType:D
    =end code
    =para Creates a new FreeType integrated font.
=end pod

    method new(
        Font::FreeType::Face:D :$ft-face!,
        hb_ft_font:D :$raw = hb_ft_font::create($ft-face.raw),
        HarfBuzz::Face() :$face = $raw.get-face(),
        |etc,
    ) {
          nextwith(:$ft-face, :$raw, :$face, |etc);
    }

multi method COERCE(% ( Font::FreeType::Face:D :$ft-face!, |etc) --> ::?CLASS:D) {
    self.new(:$ft-face, |etc);
}
=begin code :lang<raku>
multi method COERCE(
    % (Font::FreeType::Face:D :$ft-face!, |etc)
) returns HarfBuzz::Font::FreeType:D
=end code
=para Coerces a FreeType integrated font, from an options hash.

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

