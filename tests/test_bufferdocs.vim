" Test script for BufferDocs
source mapdocs.vim
source mappings.vim

" Test the BufferDocs command
BufferDocs

" Save the content to a test file
saveas /tmp/test_bufferdocs_output.md

" Exit
qa!