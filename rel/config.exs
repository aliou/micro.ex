Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"(3~.^m/q$T@9Uj~kq{eZnni_]}X5H{5N;mO=FI7PR1;)iyN(]D6VoVrx4tZQ<p7V"
end

environment :prod do
  set include_erts: false
  set include_src: false
  set cookie: :"9NM)/73ev7nZ3AAGjd{_@mPnT/.;m9r.h$6fu{iNgs*h2f9)OM%*zoak4u0fh,bX"
end

release :micro do
  set version: current_version(:micro)
  set applications: [
    :runtime_tools
  ]
end
