# Increment Semantic Version

This is a GitHub action to bump a given semantic version, depending on a given version fragment.

## Inputs

### `current-version`

**Required** The current semantic version you want to increment. (e.g. 3.12.5)

### `version-fragment`

**Required** The versions fragment you want to increment.

Possible options are **[ major | feature | bug | alpha | beta | pre | rc ]**

## Outputs

### `next-version`

The incremented version.

## Example usage

    - name: Bump release version
      id: bump_version
      uses: christian-draeger/increment-semantic-version@1.1.0
      with:
        current-version: '2.11.7-alpha.3' # also accepted: 'v2.11.7-alpha.3' | '2.11.7-alpha3'
        version-fragment: 'feature'
    - name: Do something with your bumped release version
      run: echo ${{ steps.bump_version.outputs.next-version }}
      # will print 2.12.0
      
## input / output Examples

| version-fragment | current-version |   | output         |
| ---------------- | --------------- | - | -------------- |
| major            | 2.11.7          |   | 3.0.0          |
| major            | v2.11.7         |   | 3.0.0          |
| major            | 2.11.7-alpha3   |   | 3.0.0          |
| major            | 2.11.7-alpha.3  |   | 3.0.0          |
| feature          | 2.11.7          |   | 2.12.0         |
| feature          | 2.11.7-alpha3   |   | 2.12.0         |
| feature          | 2.11.7-alpha.3  |   | 2.12.0         |
| bug              | 2.11.7          |   | 2.11.8         |
| bug              | 2.11.7-alpha3   |   | 2.11.8         |
| bug              | 2.11.7-alpha.3  |   | 2.11.8         |
| alpha            | 2.11.7          |   | 2.11.7-alpha.1 |
| alpha            | 2.11.7-alpha3   |   | 2.11.7-alpha.4 |
| alpha            | 2.11.7-alpha.3  |   | 2.11.7-alpha.4 |
| beta             | 2.11.7          |   | 2.11.7-beta.1  |
| beta             | 2.11.7-alpha3   |   | 2.11.7-beta.1  |
| beta             | 2.11.7-alpha.3  |   | 2.11.7-beta.1  |
| pre              | 2.11.7          |   | 2.11.7-pre.1   |
| pre              | 2.11.7-alpha3   |   | 2.11.7-pre.1   |
| pre              | 2.11.7-alpha.3  |   | 2.11.7-pre.1   |
| rc               | 2.11.7          |   | 2.11.7-rc.1    |
| rc               | 2.11.7-alpha3   |   | 2.11.7-rc.1    |
| rc               | 2.11.7-alpha.3  |   | 2.11.7-rc.1    |

# License
The scripts and documentation in this project are released under the [MIT License](LICENSE)
