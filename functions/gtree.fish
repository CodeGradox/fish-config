function gtree --description "Create a git worktree with automatic branch creation and setup"
    # Check if an argument was provided
    if test (count $argv) -ne 1
        echo "Usage: gtree <branch-name>"
        echo "Example: gtree feature/add-new-module"
        return 1
    end

    set branch_name $argv[1]

    # Get the current folder name
    set current_folder (basename $PWD)

    # Strip away namespace prefixes (feature/, bugfix/, etc.)
    # Extract everything after the last slash in the branch name
    set folder_suffix (string replace -r '^.+/' '' $branch_name)

    # Also strip common prefixes from the folder suffix if they exist
    set folder_suffix (string replace -r '^(feature|bugfix|hotfix|fix|bug)-' '' $folder_suffix)

    # Construct the new folder name using current folder as-is
    set new_folder_name "$current_folder-$folder_suffix"
    set new_folder_path "../$new_folder_name"

    echo "Creating worktree for branch: $branch_name"
    echo "New folder: $new_folder_path"

    # Check if branch exists, if not create it
    if not git show-ref --verify --quiet "refs/heads/$branch_name"
        echo "Branch '$branch_name' does not exist. Creating it..."
        git branch $branch_name
        if test $status -ne 0
            echo "Error: Failed to create branch"
            return 1
        end
    else
        echo "Branch '$branch_name' already exists"
    end

    # Create the worktree
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
