/**
 * buggy_app.js
 *
 * A simple Express-like user management app — intentionally written with
 * several bugs. Use this file during the demo to showcase Copilot CLI's
 * /fix command.
 *
 * Bugs hidden in this file (don't peek during the demo!):
 *   1. getUserById uses == instead of ===
 *   2. createUser doesn't validate required fields
 *   3. deleteUser mutates the array while iterating
 *   4. formatUserName has an off-by-one slice error
 *   5. calculateAge uses the wrong date comparison operator
 *   6. getUsersByRole has a case-sensitive comparison bug
 *   7. parseConfig silently swallows JSON parse errors
 */

const users = [
  { id: 1, name: "Alice Johnson",   email: "alice@example.com", role: "admin",  birthYear: 1990 },
  { id: 2, name: "Bob Smith",       email: "bob@example.com",   role: "user",   birthYear: 1985 },
  { id: 3, name: "Carol Williams",  email: "carol@example.com", role: "user",   birthYear: 1995 },
  { id: 4, name: "Dave Brown",      email: "dave@example.com",  role: "editor", birthYear: 2000 },
];

// Bug 1: loose equality (==) instead of strict equality (===)
// This means getUserById("1") and getUserById(1) return the same result
function getUserById(id) {
  return users.find((user) => user.id == id);
}

// Bug 2: no validation — name and email can be undefined
function createUser(name, email, role = "user", birthYear) {
  const newUser = {
    id: users.length + 1,
    name,
    email,
    role,
    birthYear,
  };
  users.push(newUser);
  return newUser;
}

// Bug 3: splice() inside forEach() causes skipped elements
function deleteUser(id) {
  users.forEach((user, index) => {
    if (user.id === id) {
      users.splice(index, 1); // mutating array during iteration!
    }
  });
}

// Bug 4: off-by-one — should be split(" "), not split("")
// This returns the first character of the full name instead of the first name
function formatUserName(fullName) {
  const parts = fullName.split("");
  return parts[0] + " " + parts[parts.length - 1];
}

// Bug 5: wrong operator — should be >= not <=
// This flags everyone born AFTER the cutoff as under-18
function calculateAge(birthYear) {
  const currentYear = new Date().getFullYear();
  const age = currentYear - birthYear;
  if (age <= 0) {
    return "Invalid birth year";
  }
  return age;
}

// Bug 6: case-sensitive role comparison without normalization
// "Admin" !== "admin" so admins with capital-A role won't be found
function getUsersByRole(role) {
  return users.filter((user) => user.role === role);
}

// Bug 7: silent catch — errors are swallowed, returns undefined on bad JSON
function parseConfig(jsonString) {
  try {
    return JSON.parse(jsonString);
  } catch (e) {
    // error silently ignored
  }
}

// --- Simple demo runner ---

console.log("=== User Management Demo ===\n");

console.log("All users:", users);

console.log("\nGet user by ID 2 (strict):", getUserById(2));
console.log("Get user by ID '2' (loose, should be undefined):", getUserById("2"));

console.log("\nFormatted name for 'Alice Johnson':", formatUserName("Alice Johnson"));

console.log("\nAge of user born in 1990:", calculateAge(1990));
console.log("Age of user born in 2000:", calculateAge(2000));

console.log("\nUsers with role 'admin':", getUsersByRole("admin"));
console.log("Users with role 'Admin' (should be same):", getUsersByRole("Admin"));

console.log("\nParsed config (valid JSON):", parseConfig('{"theme":"dark"}'));
console.log("Parsed config (invalid JSON):", parseConfig("not-json"));

deleteUser(3);
console.log("\nUsers after deleting id=3:", users.map((u) => u.name));
