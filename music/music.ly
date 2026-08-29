\version "2.24.0"

\header {
  title = "Hey Jude"
  subtitle = "Chorus Snippet"
  composer = "Lennon & McCartney"
}

\language "english"

% 1. Define the Chord Progressions
chordNames = \chordmode {
  \set chordChanges = ##t
  f1 | c:7 | c:7 | f |
  f:7 | bf | f2 c:7 | f1 |
}

% 2. Define the Vocal Melody
melody = \relative c'' {
  \clef treble
  \key f \major
  \time 4/4
  \tempo 4 = 76

  % Na, na, na, na-na-na-na...
  c1 ~ |
  c2. g8 a |
  bf4 d c8 bf4 a8 |
  g2. f8 g |

  a4 a c8 d4 c8 |
  \tuplet 3/2 { c8( bf a) } g4 g8 f4 g8 |
  a2 g2 |
  f1 \bar "|."
}

% 3. Define the Lyrics
verseLyrics = \lyricmode {
  Na __ _ _ _ na na na na na,
  na na na na, hey Jude.
}

% 4. Assemble the Lead Sheet
\score {
  <<
    \new ChordNames \chordNames
    \new Staff {
      \new Voice = "singer" { \melody }
    }
    \new Lyrics \lyricsto "singer" \verseLyrics
  >>
  \layout { }
  \midi { }
}

