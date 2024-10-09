package manifests

import (
	"encoding/json"
	"fmt"
	"os"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

type Resource struct {
	Object map[string]interface{} `json:",inline"`
}

func (r *Resource) UnmarshalJSON(b []byte) error {
	return json.Unmarshal(b, &r.Object)
}

func (r Resource) MarshalJSON() ([]byte, error) {
	return json.Marshal(&r.Object)
}

func (r Resource) Kind() string {
	return r.Object["kind"].(string)
}

func (r Resource) Name() string {
	metadata := r.Object["metadata"].(map[string]interface{})
	return metadata["name"].(string)
}

func AppsResources(path string) (map[string][]Resource, error) {
	ctx := cuecontext.New()
	insts := load.Instances([]string{path}, nil)
	v := ctx.BuildInstance(insts[0])
	v = v.LookupPath(cue.ParsePath("appsResources"))
	bs, err := json.Marshal(v)
	if err != nil {
		return nil, fmt.Errorf("couldn't marshal to json: %w", err)
	}
	ret := make(map[string][]Resource, 0)
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
	var ret []Resource
	err = json.Unmarshal(bs, &ret)
	return ret, err
}

func ArgoAppsApp(path string) (*Resource, error) {
	v := loadCue(path)
	v = v.LookupPath(cue.ParsePath("appsApp"))
	bs, err := json.Marshal(v)
	if err != nil {
		return nil, fmt.Errorf("couldn't marshal to json: %w", err)
	}
	var ret Resource
	err = json.Unmarshal(bs, &ret)
	return &ret, err
}

func WriteResource(p string, res Resource) error {
	f, err := os.Create(p)
	if err != nil {
		return fmt.Errorf("failed to create file: %w", err)
	}
	defer f.Close()
	encoder := json.NewEncoder(f)
	encoder.SetIndent("", "  ")
	err = encoder.Encode(res)
	if err != nil {
		return fmt.Errorf("failed to write file for %s", res)
	}
	return nil
}

func loadCue(path string) cue.Value {
	ctx := cuecontext.New()
	insts := load.Instances([]string{path}, nil)
	v := ctx.BuildInstance(insts[0])
	return v
}
