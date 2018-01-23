/**
 * Name: sh
 * Description: Bourne shell programming language.
 * Author: Juergen Kahrs <Juergen.Kahrs@t-online.de>
 *         Josh Zenker <josh.zenker@sig.com>
 */

state sh_string extends Highlight
{
  /\\\\./ {
    language_print ($0);
  }

  sh_string_end {
    language_print ($0);
    return;
  }
}

state sh extends HighlightEntry
{
  /* Comments. */
  /#/ {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* Ignore escaped quotation marks */
  /\\\"/ {
    language_print ($0);
  }

  /\\\'/ {
    language_print ($0);
  }

  /\\\`/ {
    language_print ($0);
  }

  /* String constants. */
  /\"|'/ {
    sh_string_end = regexp($0);
    string_face (true);
    language_print ($0);
    call (sh_string);
    string_face (false);
  }

  /* Ignore escaped quote marks */
  /\\\"/ {
    language_print ($0);
  }
  /\\\'/ {
    language_print ($0);
  }
  /\\\`/ {
    language_print ($0);
  }

  /* Excutable script. */
  /^#!/ {
    reference_face (true);
    language_print ($0);
    call (eat_one_line);
    reference_face (false);
  }

  /* Keywords. */
  /\b(CDPATH|HOME|IFS|MAIL((CHECK)?|(PATH)?)|P(ATH|S(1|2))|SH(ACCT|ELL)|\
break|c(ase|d|ontinue)|do(ne)?|e(cho|l(if|se)|sac|val|x(ec|it|port))|f(i|or)|\
getopts|hash|i[fn]|limit|newgrp|pwd|re(ad(only)?|turn)|s(et|hift)|\
t(est|hen|imes|rap|ype)|u(limit|mask|n(limit|set))|w(ait|hile))\b/ {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }
}


/*
Local variables:
mode: c
End:
*/
