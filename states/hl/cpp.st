/**
 * Name: cpp
 * Description: C++ programming language.
 * Author: Markku Rossi <mtr@iki.fi>
 */

cpp_type_re =
/* Types.
   (build-re '(alignas alignof and and_eq asm auto bitand bitor bool
   break case catch char char16_t char32_t class compl const constexpr
   const_cast continue decltype default delete do double dynamic_cast
   else enum explicit export extern false float for friend goto if
   inline int long mutable namespace new noexcept not not_eq nullptr
   operator or or_eq private protected public register
   reinterpret_cast return short signed sizeof static static_assert
   static_cast struct switch template this thread_local throw true try
   typedef typeid typename union unsigned using virtual void volatile
   wchar_t while xor xor_eq))
  */
  /\\b(a(lign(as|of)|nd(|_eq)|sm|uto)|b(it(and|or)|ool|reak)\\
|c(a(se|tch)|har(|16_t|32_t)|lass|o(mpl|n(st(|_cast|expr)|tinue)))\\
|d(e(cltype|fault|lete)|o(|uble)|ynamic_cast)\\
|e(lse|num|x(p(licit|ort)|tern))|f(alse|loat|or|riend)|goto\\
|i(f|n(line|t))|long|mutable|n(amespace|ew|o(except|t(|_eq))|ullptr)\\
|o(perator|r(|_eq))|p(r(ivate|otected)|ublic)\\
|re(gister|interpret_cast|turn)\\
|s(hort|i(gned|zeof)|t(atic(|_(assert|cast))|ruct)|witch)\\
|t(emplate|h(is|r(ead_local|ow))|r(ue|y)|ype(def|id|name))\\
|u(n(ion|signed)|sing)|v(irtual|o(id|latile))|w(char_t|hile)|xor(|_eq))\b/;

/*
 * We inherit the C++ state from the C state.  This gives us all the
 * defaults, etc.  All we have to do here is to overwrite things that
 * are not implemented, or are broken.
 */
state cpp extends c
{
  BEGIN {
    /* See `c.st' for the comments on this one. */
    type_re = cpp_type_re;
  }

  /* One line comments. */
  /\/\// {
    comment_face (true);
    language_print ($0);
    call (eat_one_line);
    comment_face (false);
  }

  /* Keywords; those missing from C, but not types, goto, or case
     (build-re '(asm catch delete new operator overload this throw try))
  */
  /\b(asm|catch|delete|new|o(perator|verload)|t(h(is|row)|ry))\b/ {
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /* Types. */
  cpp_type_re {
    type_face (true);
    language_print ($0);
    type_face (false);
  }

  /* Remove false labels. */
  /[a-zA-Z0-9_]+::/ {
    language_print ($0);
  }

  /* Labels.  Emacs accepts also bare numbers. */
  /^([ \t]*)([a-zA-Z0-9_]+)(:)/ {
    language_print ($1);

    if (strcmp ($2, "public") == 0
	|| strcmp ($2, "private") == 0
	|| strcmp ($2, "protected") == 0)
      {
	/* These use the `type' face. */
	type_face (true);
	language_print ($2);
	type_face (false);
      }
    else
      {
	reference_face (true);
	language_print ($2);
	reference_face (false);
      }

    language_print ($3);
  }

  /*
   * Function definitions, but only if you code with the one and only
   * usable indentation style (GNU).
   */
  /^([a-zA-Z_][a-zA-Z_0-9:~]*)([ \t]*\()/ {
    function_name_face (true);
    language_print ($1);
    function_name_face (false);

    language_print ($2);
  }

  /* Function definitions and prototypes for other (loser) coding styles. */
  /^([A-Za-z][a-zA-Z0-9_\&\* ]+)([ \*])([a-zA-Z_][a-zA-Z_0-9:~]*)([ \t]*\()/ {
    garbage = $1;
    middle_garbage = $2;
    function_name = $3;
    tail_garbage = $4;

    highlight_types (garbage, cpp_type_re);

    language_print (middle_garbage);

    function_name_face (true);
    language_print (function_name);
    function_name_face (false);

    language_print (tail_garbage);
  }
}


/*
Local variables:
mode: c
End:
*/
