\version "2.24.0"

\score {
  <<
    \new Staff {
      \relative {
        e'4 fis g a
        b2 b
      }
    }

    \new TabStaff {
      \relative {
        e'4 fis g a
        b2 b
      }
    }
  >>
}
