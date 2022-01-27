

1. 下载mit_scheme_bindings.txt

	[mit_scheme_bindings.txt](https://gist.githubusercontent.com/bobbyno/3325982/raw/fc0208d287e56adc12b4c76114fcd21a107082ad/mit_scheme_bindings.txt)

2. 安装rlwrap
	[rlwarp](https://github.com/hanslub42/rlwrap)

3. 编辑~/.bashrc
	```
	alias ischeme="rlwrap -r -c -f $HOME/mit_scheme_bindings.txt scheme"
	```

## References
- https://topfarmer.github.io/2021/02/17/Windows10-%E4%B8%8B%E5%AE%89%E8%A3%85-Mit-scheme-%E6%B5%81%E7%A8%8B-2021/
- https://stackoverflow.com/questions/11908746/mit-scheme-repl-with-command-line-history-and-tab-completion