# Contributing

Contributions to this repository include all ([Git](https://git-scm.com/)) version-controlled changes made to one or more files in the repository, specifically, in the default (`main`) branch of the repository, as well as [issues](https://github.com/ISARICResearch/Learning/issues), which count as informal contributions that are external to version control.

Changes should be submitted in the form of a [pull request](https://docs.github.com/en/pull-requests/reference/pull-requests) (PR) that must first be reviewed and approved by a repository member with the appropriate level of permission, following which the pull request is merged into the repository and the changes incorporated.

Before submitting pull requests contributors must first:

- Have a copy of the repository as a clone or fork.
- If working with a clone, check you have the right level of access to the repository, which is usually the ability to read from and write to the repository. Access is typically granted by repository maintainers,
  who are [listed](https://github.com/ISARICResearch/Learning/blob/main/README.md#maintainers)
  in the README.

The basic PR-based contributions workflow is described below in very general terms, omitting specifics of any particular tools such as Git, command line shells, IDEs etc. Some familiarity with Git and GitHub is assumed and also useful. As this is independent of the contributions workflow the relevant and appropriate documentation or external learning resources can be consulted.

## Basic PR Workflow

1.  Create a new (local) branch that will contain your changes - usually this will be created from the latest copy of the `main` branch, which is the default branch, but this could be different depending on your requirements.
2.  Push the branch upstream to the GitHub remote (usually named `origin` in Git), then [create a
    PR](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/creating-a-pull-request) from the upstream branch targeting the `main` branch, and **also mark the PR as a**
    [draft](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/changing-the-stage-of-a-pull-request#converting-a-pull-request-to-a-draft) to indicate that it is **under development** (or work in progress).
3.  Once you're satisfied with the changes, **mark the PR as** [ready for
    review](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/changing-the-stage-of-a-pull-request#marking-a-pull-request-as-ready-for-review), and [request a review](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/requesting-a-pull-request-review) from a repository member - one reviewer is sufficient and necessary, and all PRs require a minimum of one approval.
4.  If the PR is approved, merge it yourself if you have the necessary permissions, or, alternatively, request a merge from either the reviewer(s) or another repository member who can merge it.
5.  If there are questions or requested changes from the reviewer these must be addressed - this may require changes to be staged and committed on the local branch in the usual way, before updating the upstream branch (which automatically updates the PR); it may also require PR discussions to be resolved. Request another review and approval if required, and merge the PR as described above.

>[!Note]
A draft PR cannot normally be merged (except usually by repository administrators and owners), which is one of the reasons why it is advisable to mark the PR as a draft while it is still in development.

### PR Status Checks

Contributors should familiarise themselves with 
[status checks](https://docs.github.com/en/pull-requests/reference/status-checks) (running as GitHub Actions workflows) that are automatically triggered whenever a PR is updated. Currently, these are limited to:

- [CodeQL](https://securitylab.github.com/codeql-wall-of-fame/) code scanning and quality checks, some of which are specific to the principal code languages being used in the repository, namely, Typescript and Javascript.

These aren't expected to pose any problems, but please note any anomalies or errors and ensure they are resolved.

### Resolving PR Problems and Keeping the PR Up-to-date

Any PR problems such as status check errors, [merge conflicts](https://docs.github.com/en/pull-requests/reference/merge-conflicts),
or other anomalies, should be **investigated** and **resolved**.

Status check errors can be investigated by inspecting the [GitHub Actions workflow logs](https://github.com/ISARICResearch/Learning/actions) for the relevant workflow.

Merge conflicts can be [resolved locally on the command line](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requests/resolving-a-merge-conflict-using-the-command-line) **only if you're familiar with Git**, otherwise please ask a [maintainer](https://github.com/ISARICResearch/Learning/blob/main/README.md#maintainers). Merge conflicts can also be [resolved on
GitHub](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requestsresolving-a-merge-conflict-on-github). Resolving a merge conflict will always create a new merge commit in the PR branch.

Another point to note is that if the PR's target (or base) branch, usually `main`, is updated (by other PRs or direct commits) while the PR is still in development or review (and is therefore unmerged), you should see a warning on the PR status checks box that it is [out of date and should be updated](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/keeping-your-pull-request-in-sync-with-the-base-branch). This may sometimes lead to merge conflicts, which must be resolved as described above, before proceeding with further PR changes.

### PR Rules

Contributors should also note some rules that are in place and apply to
all PRs. These are:

- A PR approval is dismissed if it is updated with new commits pushed after that approval - this is to ensure that all current changes are subject to review prior to any approval. For this reason contributors should, if possible, request a review once they're satisfied that all changes are complete.
- An approved PR cannot be merged until all PR discussions/conversations are
  [resolved](https://docs.github.com/en/pull-requests/how-tos/review-pull-requests/commenting-on-a-pull-request#resolving-conversations) - this is to ensure that any lingering questions or issues raised in a discussion have been addressed before merging the PR.

These rules can only be bypassed by an [ISARICResearch GitHub organisation](https://github.com/ISARICResearch) administrator or repository administrator. Please contact a [maintainer](https://github.com/ISARICResearch/Learning/blob/main/README.md#maintainers) for further information.

## Issues

As mentioned in the introduction to this page, [creating issues](https://github.com/ISARICResearch/Learning/issues) also counts as contributions - however these are informal and not part of version control.

Issues can be used to define and discuss features, bugs and other relevant improvements or changes. They can also be linked to PRs. For more information see the [GitHub documentation](https://docs.github.com/en/issues/tracking-your-work-with-issues/learning-about-issues/quickstart).
