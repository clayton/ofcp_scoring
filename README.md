# Open Face Chinese Poker Scoring

A library for evaluating two open face chinese poker hands.

## Build Status
[![Build Status](https://travis-ci.org/clayton/ofcp_scoring.png)](https://travis-ci.org/clayton/ofcp_scoring)

## Getting Started

Without Bundler:
`gem install ofcp_scoring`

With Bundler:
Add `gem 'ofcp_scoring'` to your Gemfile

## Basic Usage

The basic scoring engine will evaluate two Chinese Poker hands calculating
royalties and scoop bonuses.

Example:

    engine = OfcpScoring::ScoringEngine.new
    engine.score(
      %w(2h 3h 5h 10d 10h 4h 7c 8s Jd Js 6c 7d 9c),
      %w(Ah 3h 5h 6d 6h 4h 7c 8s Qd Qs 6c 7d 9c)
    )
    #=> [1,2]

## Royalty Calculation

With Royalties you receive the following points for Back hands:

* 20 for a Royal
* 10 for StraightFlush
* 8 for Quads
* 6 for a Full House
* 4 for a OfcpScoring::Flush
* 2 for a Straight

You receive the following points for Middle hands:

* 20 for StraightFlush
* 16 for Quads
* 2 for a Full House
* 8 for a OfcpScoring::Flush
* 4 for a Straight

You receive the following points for Front hands (the 3 card hand):

* Pair of Aces: 9 points
* Pair of Kings: 8 points
* Pair of Queens: 7 points
* Pair of Jacks: 6 points
* Pair of Tens: 5 points
* Pair of Nines: 4 points
* Pair of Eights: 3 points
* Pair of Sevens: 2 points
* Paid of Sixes: 1 point
