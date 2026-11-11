# FRACTRAN

A [FRACTRAN](https://en.wikipedia.org/wiki/FRACTRAN) interpreter in [NC](https://nc.klado.dev).

## Usage

```
Usage: fractran <file> <input>

Arguments:
  <file>      The Fractran file to execute.
  <input>     The input to the Fractran program.

Options:
  -h, --help  Show this help and exit.
```

An example FRACTRAN input is given in [`primegame.fr`](./primegame.fr). To run it, you can run `ncc run fractran.nc -- primegame.fr 2`. This will output the prime numbers 2, 3, 5, 7 before crashing due to integer overflow.

The NC code is written specifically for PRIMEGAME at the moment, so you may need to change the [`fractran.nc`](./fractran.nc) to get the desired result for your own FRACTRAN programs.

## Build instructions

You'll need [`ncc`](https://github.com/noClaps/ncc).

```sh
ncc build -r fractran.nc
```
