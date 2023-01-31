package com.example.booksapp.view

import android.widget.Toast
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.material3.Checkbox
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.domain.Book
import kotlinx.coroutines.job


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddBookScreen(
    viewModel: BooksViewModel = hiltViewModel(),
    navigateBack: () -> Unit
) {
    Scaffold(
        topBar = { TopBar("Add book", navigateBack) },
        content = {
            AddBookContent(
                padding = it,
                addBook = { book -> viewModel.addBook(book) },
                navigateBack = navigateBack,
            )
        }
    )
}

@Composable
fun AddBookContent(
    padding: PaddingValues,
    addBook: (book: Book) -> Unit,
    navigateBack: () -> Unit
) {
    var title by remember { mutableStateOf("") }
    var author by remember { mutableStateOf("") }
    var year by remember { mutableStateOf("") }
    var lent: Boolean by remember { mutableStateOf(false) }
    val focusRequester = FocusRequester()
    val context = LocalContext.current
    val showMessage =
        { text: CharSequence -> Toast.makeText(context, text, Toast.LENGTH_SHORT).show() }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(padding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
        TextField(
            value = title,
            onValueChange = { title = it },
            label = { Text(text = "Title...") },
            modifier = Modifier.focusRequester(focusRequester),
            textStyle = TextStyle(color = Color.Magenta)
        )

        // used to set the focus on the first TextField
        LaunchedEffect(Unit) {
            coroutineContext.job.invokeOnCompletion { focusRequester.requestFocus() }
        }

        Spacer(modifier = Modifier.height(16.dp))

        TextField(
            value = author,
            onValueChange = { author = it },
            label = { Text(text = "Author...") },
            textStyle = TextStyle(color = Color.Magenta)
        )

        Spacer(modifier = Modifier.height(16.dp))

        TextField(
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number,
                capitalization = KeyboardCapitalization.None,
                autoCorrect = true,
                imeAction = ImeAction.Next,
            ),
            value = year,
            onValueChange = { year = it },
            label = { Text(text = "Year...") },
            textStyle = TextStyle(color = Color.Magenta)
        )
        
        Row (
            horizontalArrangement = Arrangement.Start,
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Checkbox( // https://www.geeksforgeeks.org/checkbox-in-android-using-jetpack-compose/
                checked = lent,
                onCheckedChange = { lent = it },
                modifier = Modifier.padding(16.dp)
            )
            Text(text = "Lent", modifier = Modifier.padding(horizontal = 0.dp, vertical = 16.dp))
        }

        Button(onClick = {
            if (title.isBlank() || author.isBlank() || year.isBlank()) {
                showMessage("Please fill all fields")
            } else if (year.toIntOrNull() == null || year.toInt() < 0) {
                showMessage("Year must be a positive integer")
            } else {
                addBook(Book(0, title, author, year.toInt(), lent))
                showMessage("Book added")
                navigateBack()
            }
        }) {
            Text(text = "Add Book")
        }
    }
}
