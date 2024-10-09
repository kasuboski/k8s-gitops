package manifests

import (
	"encoding/json"
	"fmt"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

type Resource = map[string]interface{}

func AppsResources(path string) (map[string][]Resource, error) {
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

func ArgoApps(path string) ([]Resource, error) {
	v := loadCue(path)
	v = v.LookupPath(cue.ParsePath("appOut"))
	bs, err := json.Marshal(v)
	if err != nil {
		return nil, fmt.Errorf("couldn't marshal to json: %w", err)
	}
	ret := make([]Resource, 0)
	err = json.Unmarshal(bs, &ret)
	return ret, err
}

func loadCue(path string) cue.Value {
	ctx := cuecontext.New()
	insts := load.Instances([]string{path}, nil)
	v := ctx.BuildInstance(insts[0])
	return v
}
