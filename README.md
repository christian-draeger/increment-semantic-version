# Bump Semantic Version

This is a GitHub action to increment a given semantic version by a given version fragment.

## Inputs

### `current-version`

**Required** The current semantic version you want to increment. (e.g. 3.12.5)

### `version-fragment`

**Required** The versions fragment you want to increment. 
Possible options are [ major | feature | bug | alpha | beta | rc ]

## Outputs

### `next-version`

The incremented version.

## Example usage

    - name: Bump release version
      id: bump_version
      uses: actions/bump-semantic-version@v1
      with:
        current-version: '2.11.7-alpha3'
        version-fragment: 'feature'
    - name: Do something with your bumped release version
      run: echo ${{ steps.bump_version.outputs.next-version }}