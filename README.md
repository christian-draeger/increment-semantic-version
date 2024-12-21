# Increment Semantic Version

This is a GitHub action to bump a given semantic version, depending on a given version fragment.

## Inputs

### `current-version`

**Required** The current semantic version you want to increment. (e.g. 3.12.5)

### `version-fragment`

**Required** The versions fragment you want to increment.

Possible options are **[ major | feature | minor | bug | patch | hotfix | alpha | beta | pre | rc ]**

Note: [feature | minor] and [bug | patch | hotfix] are synonyms.

## Outputs

### `next-version`

The incremented version.

## Example usage

    name: Update Version
    on:
      workflow_dispatch:
    
    env:
      CURRENT_VERSION_TOP_LEVEL: 'v2.11.7-alpha.3'
    
    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          - name: Bump release version
          id: bump_version
          uses: christian-draeger/increment-semantic-version@1.2.3
          with:
            current-version: ${{ env.CURRENT_VERSION_TOP_LEVEL }} # also accepted: 'v2.11.7-alpha.3' | '2.11.7-alpha3'
            version-fragment: 'feature'
        - name: Do something with your bumped release version
          run: echo ${{ steps.bump_version.outputs.next-version }} # will print 2.12.0
      env-set-in-job:
        runs-on: ubuntu-latest
        steps:
          - name: set current version from file
            id: set_current_version
            run: echo "::set-env name=CURRENT_VERSION::$(cat version.txt)"
          - name: Bump release version
            id: bump_version
            uses: christian-draeger/increment-semantic-version@1.2.0
            with:
              current-version: ${{ env.CURRENT_VERSION }} # also accepted: 'v2.11.7-alpha.3' | '2.11.7-alpha3'
              version-fragment: 'feature'
          - name: Do something with your bumped release version
            run: echo ${{ steps.bump_version.outputs.next-version }} # will print 2.12.0
      
## input / output Examples

| version-fragment | current-version | output         |
|------------------|-----------------|----------------|
| major            | 2.11.7          | 3.0.0          |
| major            | v2.11.7         | 3.0.0          |
| major            | 2.11.7-alpha.3  | 3.0.0          |
| feature          | 2.11.7          | 2.12.0         |
| feature          | 2.11.7-alpha.3  | 2.12.0         |
| minor            | 2.11.7          | 2.12.0         |
| minor            | 2.11.7-alpha.3  | 2.12.0         |
| bug              | 2.11.7          | 2.11.8         |
| bug              | 2.11.7-alpha.3  | 2.11.8         |
| patch            | 2.11.7          | 2.11.8         |
| patch            | 2.11.7-alpha.3  | 2.11.8         |
| hotfix           | 2.11.7          | 2.11.8         |
| hotfix           | 2.11.7-alpha.3  | 2.11.8         |
| alpha            | 2.11.7          | 2.11.7-alpha.1 |
| alpha            | 2.11.7-alpha    | 2.11.7-alpha.1 |
| alpha            | 2.11.7-alpha.3  | 2.11.7-alpha.4 |
| beta             | 2.11.7          | 2.11.7-beta.1  |
| beta             | 2.11.7-alpha.3  | 2.11.7-beta.1  |
| pre              | 2.11.7          | 2.11.7-pre.1   |
| pre              | 2.11.7-alpha.3  | 2.11.7-pre.1   |
| rc               | 2.11.7          | 2.11.7-rc.1    |
| rc               | 2.11.7-alpha.3  | 2.11.7-rc.1    |
| stable           | 2.11.7          | 2.11.7         |
| stable           | 2.11.7-alpha.3  | 2.11.7         |

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
