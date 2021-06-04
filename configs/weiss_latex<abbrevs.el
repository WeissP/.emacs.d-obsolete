(when (boundp 'latex-mode-abbrev-table)
  (clear-abbrev-table latex-mode-abbrev-table))

(define-abbrev-table 'latex-mode-abbrev-table
  '(
;;;;; Greek alphabet
    ("ga" "\\alpha" weiss--ahf)
    ("gga" "\\Alpha" weiss--ahf)
    ("gA" "\\Alpha" weiss--ahf)

    ("gb" "\\beta" weiss--ahf)
    ("ggb" "\\Beta" weiss--ahf)
    ("gB" "\\Beta" weiss--ahf)

    ("gd" "\\delta" weiss--ahf)
    ("ggd" "\\Delta" weiss--ahf)
    ("gD" "\\Delta" weiss--ahf)

    ("ge" "\\epsilon" weiss--ahf)
    ("gve" "\\varepsilon" weiss--ahf)
    ("gge" "\\Epsilon" weiss--ahf)
    ("gE" "\\Epsilon" weiss--ahf)

    ("gf" "\\phi" weiss--ahf)
    ("ggf" "\\Phi" weiss--ahf)
    ("gF" "\\Phi" weiss--ahf)

    ("gg" "\\gamma" weiss--ahf)
    ("ggg" "\\Gamma" weiss--ahf)
    ("gG" "\\Gamma" weiss--ahf)

    ("gh" "\\eta" weiss--ahf)
    ("ggh" "\\Eta" weiss--ahf)
    ("gH" "\\Eta" weiss--ahf)

    ("gk" "\\kappa" weiss--ahf)
    ("ggk" "\\Kappa" weiss--ahf)
    ("gK" "\\Kappa" weiss--ahf)

    ("gl" "\\lambda" weiss--ahf)
    ("ggl" "\\Lambda" weiss--ahf)
    ("gL" "\\Lambda" weiss--ahf)

    ("gm" "\\mu" weiss--ahf)
    ("ggm" "\\Mu" weiss--ahf)
    ("gM" "\\Mu" weiss--ahf)

    ("gn" "\\nu" weiss--ahf)
    ("ggn" "\\Nu" weiss--ahf)
    ("gN" "\\Nu" weiss--ahf)

    ("go" "\\omega" weiss--ahf)
    ("ggo" "\\Omega" weiss--ahf)
    ("gO" "\\Omega" weiss--ahf)

    ("gp" "\\pi" weiss--ahf)
    ("ggp" "\\Pi" weiss--ahf)
    ("gP" "\\Pi" weiss--ahf)

    ("gq" "\\theta" weiss--ahf)
    ("ggq" "\\Theta" weiss--ahf)
    ("gQ" "\\Theta" weiss--ahf)

    ("gr" "\\rho" weiss--ahf)
    ("ggr" "\\Rho" weiss--ahf)
    ("gR" "\\Rho" weiss--ahf)

    ("gs" "\\sigma" weiss--ahf)
    ("ggs" "\\Sigma" weiss--ahf)
    ("gS" "\\Sigma" weiss--ahf)

    ("gt" "\\tau" weiss--ahf)
    ("ggt" "\\Tau" weiss--ahf)
    ("gT" "\\Tau" weiss--ahf)

    ("gu" "\\upsilon" weiss--ahf)
    ("ggu" "\\Upsilon" weiss--ahf)
    ("gU" "\\Upsilon" weiss--ahf)

    ("gv" "\\varepsilon" weiss--ahf)
    ("gv" "\\Varepsilon" weiss--ahf)
    ("ggV" "\\Varepsilon" weiss--ahf)

    ("gw" "\\xi" weiss--ahf)
    ("gw" "\\Xi" weiss--ahf)
    ("ggW" "\\Xi" weiss--ahf)

    ("gx" "\\chi" weiss--ahf)
    ("ggx" "\\Chi" weiss--ahf)
    ("gX" "\\Chi" weiss--ahf)

    ("gy" "\\psi" weiss--ahf)
    ("ggy" "\\Psi" weiss--ahf)
    ("gY" "\\Psi" weiss--ahf)

    ("gz" "\\zeta" weiss--ahf)
    ("ggz" "\\Zeta" weiss--ahf)
    ("gZ" "\\Zeta" weiss--ahf)
;;;;; Logic
    ("la" "\\wedge " weiss--ahf)
    ("lb" "\\bot " weiss--ahf)
    ("lca" "\\cap " weiss--ahf)
    ("lcu" "\\cup " weiss--ahf)
    ("le" "\\exists " weiss--ahf)
    ("lf" "\\forall " weiss--ahf)
    ("lfj" "{\\tiny \\textifsym{d|><|d}}" weiss--ahf)  
    ("li" "\\in " weiss--ahf)
    ("lj" "\\bowtie " weiss--ahf)
    ("llj" "{\\tiny \\textifsym{d|><|}}" weiss--ahf)  
    ("ln" "\\neg " weiss--ahf)
    ("lni" "\\notin " weiss--ahf)
    ("lo" "\\vee " weiss--ahf)
    ("lrj" "{\\tiny \\textifsym{|><|d}}" weiss--ahf)  
    ("lsb" "\\subset " weiss--ahf)
    ("lsbe" "\\subseteq " weiss--ahf)
    ("lslj" "\\ltimes " weiss--ahf)  
    ("lsp" "\\supset " weiss--ahf)
    ("lspe" "\\supseteq " weiss--ahf)
    ("lsrj" "\\rtimes " weiss--ahf)  
    ("lt" "\\top " weiss--ahf)
    ("lv" "\\vdash " weiss--ahf)
    ("lvd" "\\vDash " weiss--ahf)
;;;;; equal symbols
    ("es" "\\stackrel{IV}{=} " weiss--ahf)
    ("el" "\\leq " weiss--ahf)
    ("eg" "\\ge " weiss--ahf)
    ("en" "\\neq " weiss--ahf)
    ("ea" "\\approx " weiss--ahf)
    ("ep" "\\prec " weiss--ahf)
    ("et" "\\equiv " weiss--ahf)

;;;;; operation symbols
    ("op" "\\cdot " weiss--ahf)
    ("ox" "\\times " weiss--ahf)
    ("od" "\\div " weiss--ahf)
    ("opm" "\\pm " weiss--ahf)
    ("os" "\\sqrt" weiss--ahf)
    ("of" "\\frac{▮}" weiss--ahf)
    ("oc" "\\circ " weiss--ahf)
    ("och" "\\choose " weiss--ahf)
    ("ofl" "\\lfloor ▮ \\rfloor" weiss--ahf)
    ("oce" "\\lceil ▮ \\rceil" weiss--ahf)
    ("om" "\\begin{bmatrix} \n▮ & b \\\\ \nc & d\n\\end{bmatrix}" weiss--ahf)

;;;;; arrows
    ("ar" "\\Rightarrow " weiss--ahf)
    ("aor" "\\overrightarrow{▮} " weiss--ahf)
    ("aol" "\\overleftarrow{▮} " weiss--ahf)
    ("asr" "\\rightarrow " weiss--ahf)
    ("al" "\\Leftarrow " weiss--ahf)
    ("asl" "\\leftarrow " weiss--ahf)
    ("alr" "\\Leftrightarrow " weiss--ahf)
    ("aslr" "\\leftrightarrow " weiss--ahf)
    ("at" "\\to " weiss--ahf)
    ("atr" "\\twoheadrightarrow" weiss--ahf)
    ("atl" "\\twoheadleftarrow" weiss--ahf)

;;;;; Symbols
    ("sc" "\\textcircled" weiss--ahf)
    ("si" "\\infty" weiss--ahf)
    ("sq" "\\square" weiss--ahf)
    ("ss" "\\#" weiss--ahf)
    ("se" "\\emptyset" weiss--ahf)
    ("sd" "\\dots " weiss--ahf)
    ("sb" "\\  \\ \\text{\\faBolt}" weiss--ahf)
    ("sbs" "\\verb|\\|" weiss--ahf)
    ("sqed" "$\\hfill\\blacksquare$" weiss--ahf)
    ("sl" "\\lim_{n \\to \\infty}" weiss--ahf)
    ("sm" "\\mid " weiss--ahf)
    ("sn" "\\nabla " weiss--ahf)
    ("sh" "\\hat{▮} " weiss--ahf)
    ("sp" "\\partial " weiss--ahf)

;;;;; Fast input
    ("frp" "\\mathbb{R}^+" weiss--ahf)
    ("fr" "\\mathbb{R}" weiss--ahf)
    ("fzp" "\\mathbb{Z}^+" weiss--ahf)
    ("fz" "\\mathbb{Z}" weiss--ahf)
    ("fnz" "\\mathbb{N}_0" weiss--ahf)
    ("fn" "\\mathbb{N}" weiss--ahf)

;;;;; escape
    ("b" "\\" weiss--ahf)
    ("bb" "\\\\" weiss--ahf)
    ("b-" "\\_ " weiss--ahf)

;;;;; Misc
    ("ml" "\\left" weiss--ahf)
    ("mr" "\\right" weiss--ahf)
    ("mh" "\\hfill" weiss--ahf)
    ("mn" "\\not" weiss--ahf)
    ("mp" "\\path" weiss--ahf)
    ("mb" "\\big" weiss--ahf)
    ("mbb" "\\Big" weiss--ahf)
    ("mbbb" "\\bigg" weiss--ahf)
    ("mbbbb" "\\Bigg" weiss--ahf)
    ("mnp" "\n\n\\newpage" weiss--ahf)    
    ("meq" "\\begin{equation*}\n▮\n\\end{equation}" weiss--ahf-indent)    
    ("mal" "\\begin{aligned}\n▮\n\\end{aligned}" weiss--ahf-indent)    
    ))

(provide 'weiss_latex<abbrevs)
