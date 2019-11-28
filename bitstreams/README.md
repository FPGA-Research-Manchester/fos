# Repository of accelerators
JSON is used to describe the bitstreams which are used by FOS. Each bitstream is either an accelerator or a shell.
FOS will look in this folder to find the bitstreams requested by clients.

## Shells
Shells are described by the following json format.
##### &lt;shell name&gt;.json #####
```json
{
  "name": "<shell name>",
  "bitfile": "<bitfile name>",
  "regions": [
    {"name": "<region name>", "blank": "<blanking bitfile name>", "bridge": "<blocker addr>", "addr": "<addr>"},
    {"name": "<region name>", "blank": "<blanking bitfile name>", "bridge": "<blocker addr>", "addr": "<addr>"},
    {"name": "<region name>", "blank": "<blanking bitfile name>", "bridge": "<blocker addr>", "addr": "<addr>"}
  ]
}
```

## Accelerators
Accelerators are described in the following format.
##### &lt;accelerator name&gt;.json #####
```json
{
  "name": "<accelerator name>",
  "bitfiles": [
    {"name": "<bitfile name>", "region": "<labelled region name>", "stubregions": ["<region>", "<region>"]},
    {"name": "<bitfile name>", "region": "<labelled region name>", "stubregions": ["<region>", "<region>"]},
    {"name": "<bitfile name>", "region": "<labelled region name>", "stubregions": ["<region>", "<region>"]}
  ],
  "registers": [
    {"name": "control", "offset": "0"},
    {"name": "<register name>", "offset": "<register offset>"},
    {"name": "<register name>", "offset": "<register offset>"},
    {"name": "<register name>", "offset": "<register offset>"}
  ]
}
```


## Registering Hardware Into Repo
Accelerators and shells are loaded into the repo using the following format.
##### &lt;accelerator name&gt;.json #####
```json
{
  "shell": "<shell name>",
  "accelerators": [
    "<accelerator name>",
    "<accelerator name>",
    "<accelerator name>"
  ]
}
```

