# Ellie’s awesome bash scripts 

Everything here is a function definition and anything you run will need to be modified

To run modules you need to source them

```bash
source /path/to/module
```

make sure you check the module you’re running to see the actual function you need to call

if you wanna load all of these (it’s a bad idea) run this

```shell
moduleDir=/path/to/this/repo
for i in $(ls moduleDir/*.sh)
do source "$moduleDir/$i"
done
```

