(with-eval-after-load 'ccls
  ;; use  "bsd"  "java"  "k&r"  "stroustrup"  "whitesmith"  "banner"  "gnu"  "linux"   "horstmann"
  (setq c-default-style "linux"
        indent-tabs-mode nil
        c-basic-offset 4)
  (setq c-label-minimum-indentation 0)
  (setq c-offsets-alist '(;; a multi-line C style block comment
                          ;;
                          ;; /**
                          ;;  * text
                          ;;  */
                          ;; int foo();
                          (c                     . c-lineup-C-comments)
                          ;; a multi-line string
                          ;;
                          ;; const char* s = "hello,\
                          ;; world";
                          (string                . c-lineup-dont-change)
                          ;; brace of function
                          ;;
                          ;; int add1(int x) {
                          ;;     return ++x;
                          ;; }
                          (defun-open            . 0)
                          (defun-close           . 0)
                          (defun-block-intro     . +)
                          ;; brace of class
                          ;;
                          ;; class Foo {
                          ;; public:                                 // <- access-label
                          ;; };
                          (class-open            . 0)
                          (class-close           . 0)
                          (access-label          . -)
                          ;; brace of class method
                          ;;
                          ;; class Foo {
                          ;;     friend class Bar;                   // <- friend
                          ;;     int getVar() {                      // <- inclass
                          ;;         return 42;
                          ;;     }
                          ;; };
                          (inline-open           . 0)
                          (inline-close          . 0)
                          (inclass               . +)
                          (friend                . 0)
                          ;; `noexcept' specifier indentation
                          (func-decl-cont        . +)
                          ;; brace of list
                          ;;
                          ;; int nums[] =
                          ;; {
                          ;;     0,
                          ;;     1,
                          ;;     {2},
                          ;; };
                          (brace-list-open       . 0)
                          (brace-list-close      . 0)
                          (brace-list-intro      . +)
                          (brace-list-entry      . 0)
                          (brace-entry-open      . 0)
                          ;; brace of namespace
                          ;;
                          ;; namespace ns {
                          ;; const int var = 42;
                          ;; }
                          (namespace-open        . 0)
                          (namespace-close       . 0)
                          (innamespace           . 0)
                          ;; brace of statement block
                          ;;
                          ;; int send_mail() {
                          ;;     std::mutex io_mtx;
                          ;;     {
                          ;;         std::lock_guard<std::mutex> lk(io_mtx);
                          ;;         // ...
                          ;;     }
                          ;; }
                          (block-open            . 0)
                          (block-close           . 0)
                          ;; topmost definition
                          ;;
                          ;; struct
                          ;; foo {};
                          (topmost-intro         . 0)
                          (topmost-intro-cont    . c-lineup-topmost-intro-cont)
                          ;; class member initialization list
                          ;;
                          ;; struct foo {
                          ;;     foo(int a, int b) :
                          ;;         a_(a),
                          ;;         b_(b) {}
                          ;; };
                          (member-init-intro     . +)
                          (member-init-cont      . c-lineup-multi-inher)
                          ;; class inheritance
                          ;;
                          ;; struct Derived : public Base1,
                          ;;                  public Base2 {
                          ;; };
                          (inher-intro           . +)
                          (inher-cont            . c-lineup-multi-inher)
                          ;; A C statement
                          ;;
                          ;; int main(int argc, char* argv[]) {
                          ;;     const int var1 = 42;
                          ;;     const int var2 = (argc > 1) ? 314   // <- a new statement starts
                          ;;                                 : 512;  // <- statement-cont
                          ;;     {
                          ;;         const int var3 = 42;            // <- statement-block-intro
                          ;;     }
                          ;;
                          ;;     switch (argc) {
                          ;;     case 0:                             // <- case-label
                          ;;         break;                          // <- statement-case-intro
                          ;;
                          ;;     case 1:
                          ;;         {                               // <- statement-case-open
                          ;;             const int tmp = 101;
                          ;;         }
                          ;;         break;
                          ;;     }
                          ;;
                          ;;     if (argc == 1)
                          ;;         assert(argc == 1);              // <- substatement
                          ;;
                          ;;     if (argc == 1)
                          ;;     {                                   // <- substatement-open
                          ;;         assert(argc == 1);
                          ;;     }
                          ;;
                          ;;     // comments                         // <- comment-intro
                          ;;     if (argc == 1)
                          ;;     glabel:                             // <- substatement-label
                          ;;         assert(argc == 1);
                          ;;
                          ;; error:                                  // <- label, with zero `c-label-minimum-indentation'
                          ;;     return -1;
                          ;; }
                          (statement             . 0)
                          (statement-cont        . (c-lineup-ternary-bodies +))
                          (statement-block-intro . +)
                          (statement-case-intro  . +)
                          (statement-case-open   . +)
                          (substatement          . +)
                          (substatement-open     . 0)
                          (substatement-label    . 0)
                          (case-label            . 0)
                          (label                 . 0)
                          (do-while-closure      . 0)
                          (else-clause           . 0)
                          (catch-clause          . 0)
                          (comment-intro         . c-lineup-comment)
                          ;; funcall with arglist
                          ;;
                          ;; sum(
                          ;;     1, 2, 3
                          ;; );
                          (arglist-intro         . +)
                          (arglist-cont          . 0)
                          (arglist-cont-nonempty . c-lineup-arglist)
                          (arglist-close         . c-lineup-close-paren)
                          ;; operator>> and operator<< for cin/cout
                          ;;
                          ;; std::cin >> a
                          ;;          >> b;
                          ;; std::cout << a
                          ;;           << b;
                          (stream-op             . c-lineup-streamop)
                          ;; macros
                          ;;
                          ;; #define ALIST(G)                                \
                          ;;     G(1)                                        \
                          ;;     G(2)
                          (cpp-macro             . -1000)
                          (cpp-macro-cont        . +)
                          ;; extern
                          ;;
                          ;; extern "C" {
                          ;; void test();
                          ;; }
                          (extern-lang-open      . 0)
                          (extern-lang-close     . 0)
                          (inextern-lang         . 0)
                          ;; lambda
                          ;;
                          ;; auto f = [](int a, int b) {
                          ;;     return a + b;
                          ;; };
                          (inlambda              . 0)
                          (lambda-intro-cont     . +)
                          ;; GNU extension, a compound statement as expression
                          ;;
                          ;; int x = 1, y = 2;
                          ;; int z = ({
                          ;;     int ret;
                          ;;     if (y > 0)
                          ;;         ret = y;
                          ;;     else
                          ;;         ret = x - y;
                          ;;     ret;
                          ;; });
                          (inexpr-statement      . 0)
                          ;; c++ template args
                          ;;
                          ;; dummy<int,
                          ;;       char,
                          ;;       double>(0, 0, 0);
                          (template-args-cont    . (c-lineup-template-args +))))

  )

(provide 'weiss_format<ccls<lsp-mode)
