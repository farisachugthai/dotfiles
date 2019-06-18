_node_complete() {
  local cur_word options
  cur_word="${COMP_WORDS[COMP_CWORD]}"
  if [[ "${cur_word}" == -* ]] ; then
    COMPREPLY=( $(compgen -W '--abort-on-uncaught-exception --experimental-report --http-server-default-timeout --report-filename --track-heap-objects --report-on-fatalerror --max-old-space-size --tls-min-v1.0 --tls-min-v1.3 --redirect-warnings --trace-tls --report-signal --report-directory --inspect-brk --preserve-symlinks-main --interactive --tls-max-v1.2 --inspect-brk-node --report-uncaught-exception --debug --heap-prof-dir --no-deprecation --trace-deprecation --print --perf-prof-unwinding-info --inspect-port --unhandled-rejections --trace-sync-io --report-on-signal --heap-prof-interval --perf-basic-prof --cpu-prof-interval --perf-basic-prof-only-functions --no-warnings --heap-prof-name --preserve-symlinks --perf-prof --heapsnapshot-signal --completion-bash --help --frozen-intrinsics --trace-warnings --expose-internals --cpu-prof-name --loader --eval --inspect --experimental-wasm-modules --tls-cipher-list --no-force-async-hooks-checks --http-parser --tls-min-v1.1 --napi-modules --use-openssl-ca --icu-data-dir --heap-prof --input-type --v8-options --require --use-bundled-ca --experimental-policy --version --experimental-vm-modules --security-reverts --es-module-specifier-resolution --pending-deprecation --experimental-worker --debug-arraybuffer-allocations --zero-fill-buffers --check --trace-event-file-pattern --tls-max-v1.3 --tls-min-v1.2 --v8-pool-size [ssl_openssl_cert_store] --prof-process [has_eval_string] --throw-deprecation --max-http-header-size --cpu-prof --experimental-modules --openssl-config --cpu-prof-dir --trace-event-categories --stack-trace-limit --debug-brk --experimental-repl-await --title --debug-port --prof-process --debug= -p -pe -v --inspect-brk= -i --print <arg> --inspect= --debug-brk= -e --inspect-brk-node= -c -h -r --trace-events-enabled' -- "${cur_word}") )
    return 0
  else
    COMPREPLY=( $(compgen -f "${cur_word}") )
    return 0
  fi
}
complete -F _node_complete node node_g