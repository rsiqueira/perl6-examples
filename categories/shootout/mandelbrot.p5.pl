#!/usr/bin/perl

# The Computer Language Benchmarks game - Mandelbrot Set Algorithm - Perl 5
# http://benchmarksgame.alioth.debian.org/

# Created by Rodrigo Siqueira (@rsiqueira)
# Creation date: 2016-01-02

# Create the Mandelbrot Set
# outputs a PBM image file to stdout.
#
# Usage:
# perl mandelbrot-perl5.pl 200 > image.pbm


my $MAXITER = 50;
my $xmin = -1.5;
my $ymin = -1.0;

my $w = shift;
$w ||= 200;
my $h = $w;

my $invN = 2/$w;

print "P4\n$w $h\n"; # Prints PBM image header

my $bit_num = 0;

my $is_set=1;

my $byte = 0;


for my $y (0..$h-1) {

  my $Ci = $y * $invN + $ymin; # y coord

  for my $x (0..$w-1) {

    my ($Zr, $Zi, $Tr, $Ti);

    my $Cr = $x * $invN + $xmin; # x coord

    for (1..$MAXITER) { # Iterate

      $Zi = 2 * $Zr * $Zi + $Ci;
      $Zr = $Tr - $Ti + $Cr;
      $Ti = $Zi * $Zi;
      $Tr = $Zr * $Zr;

      if ($Tr + $Ti > 4) { # Outer area of the Mandelbrot Set
        $is_set = 0;
        last;
      }

    }

#    if ($is_set) { # Inner area of the Mandelbrot Set
#      print "o";
#    } else {       # Outer area
#      print ".";
#    }

    $bit_num++;

    $byte = $byte << 1;
    if ($is_set) {
      $byte = $byte | 1;
    }

    if ($bit_num == 8) {

      $bit_num = 0;
      print chr($byte);
      $byte = 0;

    } elsif ($x == $w-1) { # (8 - $w%8) bits to fill out the last byte in the row

      $byte = $byte << (8 - $w%8);
      print chr($byte);
      $byte = 0;
      $bit_num = 0;
    }

    $is_set=1;

  } # Next x

#  print "\n";

} # Next y
