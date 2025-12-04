function gtree --description "Create a git worktree with automatic branch creation and setup"
    # Parse arguments
    argparse 'd/directory=' -- $argv
    or return 1

    # Check if a branch name was provided
    if test (count $argv) -ne 1
        echo "Usage: gtree <branch-name> [-d <base-directory-name>]"
        echo "Example: gtree feature/add-new-module"
        echo "Example: gtree feature/add-users -d laft-web"
        return 1
    end

    set branch_name $argv[1]

    # Get the base folder name (either from -d flag or current folder)
    if set -q _flag_directory
        set base_folder $_flag_directory
    else
        set base_folder (basename $PWD)
    end

    # Convert namespace slashes to dashes (e.g., feature/add-users -> feature-add-users)
    set folder_suffix (string replace -a '/' '-' $branch_name)

    # Construct the new folder name
    set new_folder_name "$base_folder-$folder_suffix"
    set new_folder_path "../$new_folder_name"

    echo "Creating worktree for branch: $branch_name"
    echo "New folder: $new_folder_path"

    # Fetch latest remote branches
    echo "Fetching latest branches from remote..."
    git fetch
    if test $status -ne 0
        echo "Warning: Failed to fetch from remote, continuing anyway..."
    end

    # Check if branch exists locally or remotely
    set local_exists (git show-ref --verify --quiet "refs/heads/$branch_name"; echo $status)
    set remote_exists (git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; echo $status)

    if test $local_exists -eq 0
        echo "Branch '$branch_name' exists locally"
    else if test $remote_exists -eq 0
        echo "Branch '$branch_name' exists on remote, will track it"
        # Let git worktree add handle the tracking setup
    else
        echo "Branch '$branch_name' does not exist locally or on remote. Creating new local branch..."
        git branch $branch_name
        if test $status -ne 0
            echo "Error: Failed to create branch"
            return 1
        end
    end

    # Create the worktree
    # If the branch exists on remote but not locally, this will automatically
    # create a local tracking branch
    git worktree add $new_folder_path $branch_name
    if test $status -ne 0
        echo "Error: Failed to create worktree"
        return 1
    end

    # Copy .env.local if it exists
    if test -f .env.local
        echo "Copying .env.local to new worktree..."
        cp .env.local $new_folder_path/.env.local
    else
        echo "No .env.local file found to copy"
    end

    # Open in Zed
    echo "Opening project in Zed..."
    zed $new_folder_path

    echo "Worktree created successfully!"
end
