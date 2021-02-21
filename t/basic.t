use HarfBuzz;
use HarfBuzz::Shaper;
use HarfBuzz::Font::FreeType;
use HarfBuzz::Raw::Defs :hb-script, :hb-direction;
use Test;
use Font::FreeType;
use Font::FreeType::Face;
use Font::FreeType::Raw::Defs;

plan 10;

my $version = HarfBuzz.version;
unless $version >= v1.6.0 {
    skip-rest "HarfBuzz version $version is too old to run these tests";
    exit;
}

my $file = 't/fonts/TimesNewRomPS.pfb';
my Font::FreeType::Face $ft-face = Font::FreeType.new.face($file);
my $size = 36;
my @scale = 1000, 1000;
my HarfBuzz::Font::FreeType() $font = { :$ft-face, :$size, :@scale};
my HarfBuzz::Shaper $hb .= new: :buf{:text<Hell€!>, :language<epo>}, :$font;
ok $hb.font === $font;
is $hb.size, 36;
is $hb.scale[0], 1000;
is $hb.length, 6;
is $hb.language, 'epo';
is $hb.script, HB_SCRIPT_LATIN;
is $hb.script, 'Latn';
is $hb.direction, +HB_DIRECTION_LTR;
is $hb.ft-load-flags, +FT_LOAD_NO_HINTING;
my @info = $hb.shape>>.ast;
my @expected = [
  {
    ax => 25.99,
    ay => 0.0,
    dx => 0.0,
    dy => 0.0,
    g => 62,
    name => 'H',
  },
  {
    ax => 15.98,
    ay => 0.0,
    dx => 0.0,
    dy => 0.0,
    g => 91,
    name => 'e',
  },
  {
    ax => 10.01,
    ay => 0.0,
    dx => 0.0,
    dy => 0.0,
    g => 98,
    name => 'l',
  },
  {
    ax => 10.01,
    ay => 0.0,
    dx => 0.0,
    dy => 0.0,
    g => 98,
    name => 'l',
  },
  {
    ax => 9.00,
    ay => 0.0,
    dx => 0.0,
    dy => 0.0,
    g => 0,
    name => '.notdef',
  },
  {
    ax => 11.99,
    ay => 0.0,
    dx => 0.0,
    dy => 0.0,
    g => 23,
    name => 'exclam',
  },
];

unless HarfBuzz::Shaper.version >= v2.6.6 {
    # name not available in older HarfBuzz versions
    .<name>:delete for flat @expected, @info;
}
is-deeply @info, @expected;
