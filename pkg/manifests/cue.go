package manifests

import (
	"encoding/json"
	"fmt"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

func AppsResources(path string) (map[string][]map[string]interface{}, error) {
	ctx := cuecontext.New()
	insts := load.Instances([]string{path}, nil)
	v := ctx.BuildInstance(insts[0])
	v = v.LookupPath(cue.ParsePath("appsResources"))
	bs, err := json.Marshal(v)
	if err != nil {
		return nil, fmt.Errorf("couldn't marshal to json: %w", err)
	}
	ret := make(map[string][]map[string]interface{}, 0)
	err = json.Unmarshal(bs, &ret)
	return ret, err
}
