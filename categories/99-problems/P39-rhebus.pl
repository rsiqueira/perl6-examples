use v6;

=begin pod

=TITLE P39 - A list of prime numbers.

=AUTHOR Philip Potter

=head1 Specification

    P39 (*) A list of prime numbers.
      Given a range of integers by its lower and upper limit, construct a list
      of all prime numbers in that range.

=head1 Example

    > say ~primes(10..20);
    11 13 17 19

=end pod

# Copied from P31-rhebus.pl
sub is_prime (Int $n) {
    for 2..sqrt $n -> $k {
        return Bool::False if $n %% $k;
    }
    return Bool::True;
}


# *@range is a slurpy parameter - it will swallow all the arguments passed
sub primes (*@range) {
    gather for @range {
        take $_ if is_prime $_;
    }
}

# we can call it with a range, as in the specification...
say ~primes(10..20);

# or we can pass a list...
say ~primes(3,5,17,257,65537);

# or a series...
say ~primes(1,2,*+1...100);

# vim: expandtab shiftwidth=4 ft=perl6
