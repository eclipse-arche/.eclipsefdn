local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('automotive.arche', 'eclipse-arche') {
  settings+: {
    description: "The resources to develop and build DSLs for creating automotive EE & SW architecture using Jetbrains MPS.",
    name: "Eclipse ArchE",
    location: "Germany",
    default_branch_name: "main",
    default_repository_permission: "none",
    has_discussions: true,
    discussion_source_repository: "eclipse-arche/arche",
    has_organization_projects: false,
    members_can_change_project_visibility: false,
    members_can_change_repo_visibility: false,
    members_can_create_private_repositories: false,
    members_can_create_public_repositories: false,
    members_can_create_teams: false,
    members_can_delete_repositories: false,
    members_can_delete_issues: true,
    members_can_fork_private_repositories: false,
    packages_containers_internal: true,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    two_factor_requirement: true,
    web_commit_signoff_required: false,
    workflows+: {
      enabled_repositories: "all",
      allowed_actions: "all",
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "read",
    },
  },
  rulesets: [
    orgs.newOrgRuleset('main') {
      include_repo_names: [
        "arche"
      ],
      target: "branch",
      enforcement: "active",
      include_refs+: [
        "~DEFAULT_BRANCH"
      ],
      required_pull_request: orgs.newPullRequest() {
        required_approving_review_count: 1,
        dismisses_stale_reviews: false,
        requires_review_thread_resolution: true,
      },
      required_status_checks: orgs.newStatusChecks() {
        strict: true,
        status_checks+: [
          "build_platform"
        ]
      },
      requires_linear_history: true,
    },
    orgs.newOrgRuleset('tags') {
      include_repo_names: [
        "arche"
      ],
      target: "tag",
      enforcement: "active",
      include_refs+: [
        "~ALL"
      ],
      bypass_actors: [
        "@eclipse-arche/automotive-arche-project-leads"
      ],
      allows_creations: true,
      allows_deletions: true,
    },
  ],
  _repositories+:: [
    orgs.newRepo('arche') {
      name: "arche",
      homepage: "https://projects.eclipse.org/projects/automotive.arche",
      allow_auto_merge: true,
      allow_forking: true,
      allow_squash_merge: true,
      allow_update_branch: true,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_query_suite: "default",
      // Repository does not yet contain sources for those languages, code scanning cannot yet bet defined.
      // code_scanning_default_languages: [
      //   "java-kotlin", "javascript-typescript", "python", "actions"
      // ],
      default_branch: "main",
      delete_branch_on_merge: true,
      dependabot_alerts_enabled: true,
      dependabot_security_updates_enabled: true,
      has_discussions: true,
      has_issues: true,
      squash_merge_commit_title: "PR_TITLE",
      squash_merge_commit_message: "PR_BODY",
      description: "ArchE: Set of domain specific languages to support modeling automotive electronics and software architecture.",
      secret_scanning: "enabled",
      secret_scanning_push_protection: "enabled",
      web_commit_signoff_required: false,
    },
  ],
}
